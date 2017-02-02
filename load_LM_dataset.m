%%grabs first 40,000,000 samples of LM_dataset and sets them into a database
D = dir(pwd);%grabs directory information
database=cell(5,10);
database_name=cell(5,10);
row=1;
column=1;
for i=1:length(D)
    str='.float32';
    k=strfind(D(i).name,str);
    if(isempty(k)==0)
        name=D(i).name;
        data = read_complex_binary (name, 40000000);%saves first 40,000,000 samples of file into a dataset array
        database{row,column}=data;
        database_name{row,column}=name;
        column=column+1;
        if (column==11)
            column=1;
            row=row+1;
        end
    end
end
name='data.mat';
save(name,'database_name','database');