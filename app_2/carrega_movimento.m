% This code belongs to the HDM05 mocap database which can be obtained
% from the website http://www.mpi-inf.mpg.de/resources/HDM05 .
%
% If you use and publish results based on this code and data, please
% cite the following technical report:
%
%   @techreport{MuellerRCEKW07_HDM05-Docu,
%     author = {Meinard M{\"u}ller and Tido R{\"o}der and Michael Clausen and Bernd Eberhardt and Bj{\"o}rn Kr{\"u}ger and Andreas Weber},
%     title = {Documentation: Mocap Database {HDM05}},
%     institution = {Universit{\"a}t Bonn},
%     number = {CG-2007-2},
%     year = {2007}
%   }
%
%
% THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
% KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
% PARTICULAR PURPOSE.
clear all;
close all;
clc;

addpath(genpath('parser'))
addpath(genpath('animate'))
addpath('quaternions')

pasta='throwBasketball';
cont=[];

for ator=1:5

    asf='data/%s/HDM_%d.asf';
    amc='data/%s/HDM_%d_%d.amc';
    arq='data/%s/HDM_%d*.amc';
    
    arq2=sprintf(arq,pasta,ator); % concatenando string com numero
    
    arquivos=ls(arq2); % lista arquivos por usuario
    n=sum(arquivos=='.'); % quantos arquivos esse user tem
    
    cont=[cont,n]
    
    for repeticao=1:n
        primeiro=sprintf(asf,pasta,ator);
        segundo=sprintf(amc,pasta,ator,repeticao);
        
        [skel,mot] = readMocap(primeiro, segundo);
%         nome=sprintf('%s_%d_%d.mat',pasta,ator,repeticao);
%         save(nome, 'mot')
%         
% %         clear mot
% %         clear skel
     end
end

%% load input files
% [skel,mot]       = readMocap('data/HDM_dg.asf', 'data/HDM_dg_06-03_03_120.amc');
% [skelC3D,motC3D] = readMocap('data/HDM_dg_06-03_03_120.c3d', [], false);
% 
% %% animate asf/amc file
% animate(skel, mot);

%% animate C3D file
%animate(skelC3D, motC3D)



