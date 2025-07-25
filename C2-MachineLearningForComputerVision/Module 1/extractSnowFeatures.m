function snowTable = extractSnowFeatures(ds)
saturationAvg = [];
saturationSTD = [];
imgName = [];

while hasdata(ds)
    [img, info] = read(ds);

    img = rgb2hsv(img);
    img = img(:, :, 2);

    saturationAvg = [saturationAvg; mean(img(:))];
    saturationSTD = [saturationSTD; std(img(:))];

    [~, name, ext] = fileparts(info.Filename);
    imgName = [imgName; string(name) + string(ext)];
end

% Finally create a table
label = categorical(ds.Labels);
snowTable = table(imgName, label, saturationAvg, saturationSTD);
end