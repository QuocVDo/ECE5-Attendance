%Written By  Quoc-Zuy Do

clear all
close all
clc


%get the values in the Excel using xlsread. 
%Top corner is A2, bottom c orner is E200.
%Max class size is 200, change this  if you want to increase
[num,txt,raw] = xlsread('FA22 Roster.xlsx', 'A2:E200');

%copy into classinfo
classinfo = raw;
rowsToRemove = []

%rearrange columns into the  format that the GUI expects
classinfo = classinfo(:, [2,1,4,3,5]);

%loop through every value, turn all invalid stirngs into empty stirngs
% turn  all invalid SSID's  to 404 (not found)
for i = 1:size(classinfo)

    %if invalid name remove the row
    if isnan(classinfo{i,1})
        rowsToRemove = [rowsToRemove, i];
    end
    
    %if invalid email (col 3) set to emtpy st ring
    if isnan(classinfo{i,3})
        classinfo{i,3} = '';
    end

    %if invalid PID (col 4)  set to empty string
    if isnan(classinfo{i,4})
        classinfo{i,4} = '';
    end
    
    %if SSID is NaN or is not a double, replace with error 404 not found
    if isnan(classinfo{i,5}) | (~isa(classinfo{i,5}, 'double'));
        classinfo{i,5} = 404;
    end

end

%remove the rows that have invalid names
classinfo(rowsToRemove,:) = [];





%save into 
save('classinfo.mat','classinfo')