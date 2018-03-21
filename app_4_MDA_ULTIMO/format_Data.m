function out = format_Data(data,var_fmt,nx,ny,nz,int_method)

    switch var_fmt
        case 'i'
            out = int8(100.*resize(double(data),[nx ny nz],int_method));
        case 'd'
            out = resize(double(data),[nx ny nz],int_method);
    end
end