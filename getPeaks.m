%This function takes as inputs; a numeric vector "v", an integer
%"num_peaks, and an integer "num_neighbors". It returns a (num_peaks x 2)
% matrix, with the first column representing the averaged peaks and the 
% second coumn the corresponding location 
function peaks = getPeaks(vec,num_peaks, num_neighbors, flag)

%variable creation
temp1 = vec;
temp2 = vec;
%temp3 = vec;
%sorted = zeros(num_peaks);
maxes = zeros(num_peaks,2);
avg = zeros(num_peaks,2);

%loop to get the num_peak number of peaks
for i = 1:num_peaks

[maxes(i,1), maxes(i,2)] = max(temp1);

%TODO: do we want peaks close to another?
if flag
    for j = 1:num_neighbors
    
        
        
        %remove the most recent max, and its num_neighbors

        temp1(cast(maxes(i,2),"uint64") - j) = -1;
        temp1(cast(maxes(i,2),"uint64") + j) = -1;
        

    end
end

    temp1(maxes(i,2)) = -1;

end
t = size(temp2);

%loop to get the num_neighbors average of the num_peaks
for i = 1:num_peaks

    %cast the location as integers
    c = cast(maxes(i,2),"uint64");
   
    s = size(temp2,1);

    %make sure the peak value being checked has at leastnum_neighbors to
    %the left and right, check1 and check 2 are binary
    check1 = (c - num_neighbors > 0);
    check2 = ((c + num_neighbors) <= s);

    %if check1 and check2 are satisfied, proceed with the num_neighbor
    %averaging
    if (check1 && check2)

        sum = 0;
       
        %loop to get the num_neighbor average for a given peak
        for k = 1:num_neighbors
            
            sum = sum + (temp2(cast(maxes(i,2),"uint64") - k) + temp2(cast(maxes(i,2),"uint64") + k));

        end
        
        %cast the location of the new averaged peaks as an integer
        c3 = cast(maxes(i,2),"uint64");

        avg(i,1) = ((temp2(c3) + sum) / (2*k + 1));
        avg(i,2) = cast(maxes(i,2),"uint64");

    end



end

m = max(avg)

 

end