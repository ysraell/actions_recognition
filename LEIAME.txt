
Aplicação de reconhecimento de ações baseado em álgebra tensorial. 
Autor: Israel Gonçalves de Oliveira <prof.israel@gmail.com>.

Obs. 1: Aquele que continuar esse trabalho pode entrar em contato com o autor para
dirimir possíveis dúvidas, sem problemas.

Obs. 2: As bases de dados não estão aqui, tens de pegá-las nos respectivos sites.
Todas as bases são acessíveis sem autorização prévia. Os códigos que formatam as
bases estão na forma 'make_dataset_*.m'. 

Obs. 3: São utilizadas bibliotecas de terceiros

1) Para a representação e cálculos tensoriais, são utilizadas as bibliotecas:
Tensorlab: https://www.tensorlab.net/
TensorToolbox: http://www.sandia.gov/~tgkolda/TensorToolbox/
O ganho de eficiência no desenvolvimento e no processamento é imprescindível para 
o trabalho. Recomendo a leitura do guia de usuário do Tensorlab.
Guia de usuário do Tensorlab: https://www.tensorlab.net/userguide3.pdf

2) Para o SVM, é utilizada a LIBSVM. Não é utilizado o pacote de SVM do MATLAB. 
A LIBSVM é mais fácil de usar, é eficiente e disponibiliza as diferentes formas
de SVM, como o SVM clássico, o C-SVM e o v-SVM, além de fácil modificação do
kernel e processamento mais rápido.
LIBSVM: https://www.csie.ntu.edu.tw/~cjlin/libsvm/

3) Nos casos de cálculo de normas (ou qualquer outra métrica de distância como a
SSIM e W-SSIM), foram utilizados recursos da biblioteca Eigen3 em C++. A forma
de compilar está no formato LINUX, mas pode ser compilado via MATLAB em sistemas
Windows sem problemas, bastando mudar o formato de endereços. No Linux, a barra
é '/' e no Windows é '\'. Nos códigos, estão disponíveis as alternativas do 
MATLAB, todavia, dependendo do experimento, o tempo necessário pode sofrer um a-
créscimo demasiado (algo em torno de mais de 10 vezes).

4) Há outras bibliotecas mas essas dependem da base de dados a ser utilizada. No
código o qual será utilizada alguma que não foi citada nesse documento, está o
link e o nome adequado da biblioteca em questão.


Segue abaixo uma breve descrição de cada diretório:

app_1) Primeira implementação dos métodos de MDA com ações da base HDM05 [2] no 
espaço angular relativos entre as principais* juntas (2D, SMIJ). Baseado no artigo [1], sem modificações.
*Na forma SMIJ, são selecionadas as juntas com maior variância nos movimentos, 
ou seja, as juntas com informações mais significativas.

app_2) Implementando algumas modificações nos métodos de [1] e utilizando, tam-
bém a base HDM05 [2] no espaço XYZ, a posição das juntas (3D).

app_3) Um conjunto de implementações: com SVM, LDA, PCA, k-means, k-means++, k-NN
e as variantes do MDA. Os métodos MDA de [1] foram generalizados para MDA direto
e indireto (iterativo), com critério clássico e com máxima diferença entre espa-
lhamentos. Todas as variantes de [1] podem ser generalizadas dessa forma. Nessa
aplicação, não há comparação com outros artigos, o objetivo seria gerar um proto-
colo experimental próprio. Também é a primeira tentativa de se usar diversas ba-
ses diferentes. Nesse conjunto, não foram implementados protocolos de outros ar-
tigos. 

app_3_cesup) O mesmo que o app_3, mas com modificações para rodar na plataforma
do CESUP. Infelizmente, não há uma forma oficial de usar o MATLAB nos servidores
do CESUP. Existe o programa instalado e roda direto pelo usuário, mas não roda
na plataforma de processamento distribuído, tanto em CPUs quanto em GPUs. Além 
disso, talvez seja importante observar o serviço e manutenção oferecidos. Talvez,
alternativas como a plataforma Google Cloud seja bem mais útil, apesar de paga.

app_4_MDA_ULTIMO) Última versão, correta e com bom desempenho, inclusive batendo
vários métodos do estado da arte. As variações do MDA foram generalizadas e no 
passo de teste, a distância pode ser calculada por k-NN, para qq k. Há casos em
que um k = 4, 5, melhora a performance. Nesse ponto, faltou verificar se um MDA
(redução de dimensionalidade) seguido de um SVM. Em teste preliminares foi pos-
sível obter bons resultados. Nesse conjunto, foram implementados vários protoco-
los de experimentos, de vários artigos.

app_5_TensorProj) Alternativa ao MDA. Enquanto o MDA estende a estatística do LDA
para tensores, é proposto uma redução no espaço tensorial usando as decomposições.
O problema é a unicidade nas decomposições, e, talvez, isso pode ser contornado
com a adição de restrições. Resultados bons, que confirmam a teoria, foram obti-
dos apenas com bases bem pequenas: 3 fotos de faces para treino e mais 3 para
teste. Com o aumento da base, a decomposição demanda um rank altíssimo, imprati-
cável. Um possível solução seria a decomposição em pequenos grupos, mas aí entra-
mos no problema da unicidade. Um método recursivo talvez seja a solução, seme-
lhante ao gradiente descendente estocástico, decompõem amostra após amostra com
os fatores de interesse como restrições.

Datasets_actions) As bases usadas, apenas o nome e algum código usado. Todas as
bases ocupam aprox. 20 GB.

Códigos de forma geral:

make_dataset*.m: gera as bases.

gen_*.m: gera algo, como os rounds de teste, o protocolo de validação cruzada etc.

*_actions.m: o método exato, roda individualmente para um dado conjunto de parâ-
metros, uma dada configuração experimental.
Pode variar quanto a forma de classificação, se for por modelo preditivo, é ape-
nas um teste. No caso de comparação por vizinhos mais próximos, há casos em que 
pode-se passar mais de um método de distância. Formato abandonado na última ver-
são.

MDA.m: MDA indireto (clássico) e com MSD por parâmetro.
DMDA.m e DMSD.m: MDA direto e com MSD, respectivamente.

test_*.m: de forma geral, é a primeira busca dos parâmetros e uma forma de veri-
ficar a formatação da base. A formatação da base afeta severamente o desempenho.

search_*.m: de forma geral, é escolhido um espaço de parâmetros e/ou um conjunto
de formatações da base, então é feita uma busca exaustiva pelo conjunto que maxi-
mize a performance de classificação. 

*check*.m ou *results*.m: apresenta os resultados, principalmente quando há expe-
rimentos com seleção randômica de amostras de teste e treino.

Conclusões finais:

1) Caso queira continuar essas implementações, cuide em reimplementar usando GPU.

2) Algo que poderia ser melhor explorado é o uso do MDA seguido de um método que 
gere um modelo preditivo, como o SVM, redes neurais etc. A metodologia k-NN é
muito ineficiente na prática. Para fins acadêmicos, sim, mas um método que preci-
se ser comparado com as amostras de treino tende a cair no desuso. Outra vanta-
gem, é que a redução de dimensionalidade causa a direta diminuição do custo com-
putacional do método preditivo seguinte. 

3) No caso 2 (acima), recomendo uma reimplementação completa em Python. Caso haja
disponibilidade de usar o MATLAB ou o Octave, pode-se carregar e formatar as ba-
ses e salvar no formato CVS ou como definição padrão do Python e carregar a vari-
ável com 'import'. Pode-se também rescrever tudo em Python, mas o principal é po-
der usar os recursos de multithread e GPU das bibliotecas em Python. As bibliote-
cas de machine learning em Python (e C++) são mais eficientes que no MATLAB. O 
ponto forte do MATLAB são as bibliotecas tensoriais, mas há formas de contornar
isso usando representações matriciais em C++ e bibliotecas específicas em Python.


[1] LI, Qun; SCHONFELD, Dan. Multilinear discriminant analysis for higher-order tensor data classification. IEEE transactions on pattern analysis and machine intelligence, v. 36, n. 12, p. 2524-2537, 2014.

[2] MÜLLER, Meinard et al. Documentation mocap database hdm05. 2007.
