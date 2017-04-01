
annotfile = [getenv('SUBJECTS_DIR'), '/fsaverage/label/lh.aparc.annot'];
csv_file = './vis_example.csv';
metric_list = {'Area0'}; % more than one column is allowed.
label_col = 'Label.name';

csv_dat = importdata(csv_file);
col_names = csv_dat.textdata(1,:);
label_col_ind = find(ismember(csv_dat.textdata(1,:),'Label.name'));
label_list = csv_dat.textdata(2:end,label_col_ind);
annotnames = strvcat(label_list);

for metric = metric_list
    out_file = strcat(metric, '_vals.mgh');
    metric_col_ind = find(ismember(csv_dat.textdata(1,:),metric));
    annotvals = csv_dat.data(:, metric_col_ind-2);
    
    surfoverlay = annotval2surfoverlay(annotvals',annotnames,annotfile);
    clear mri
    mri.vol = surfoverlay;
    MRIwrite(mri,char(out_file));
end;


%Run this command from a linux shell:
%tksurferfv fsaverage lh inflated -aparc -ov Area0_vals.mgh -fminmax 0 30
 
