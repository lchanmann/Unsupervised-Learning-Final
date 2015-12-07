function [a, clabel] = evaluate( clustering, desired )
%EVALUATEs the clustering with respect to the desired class labels
% Inputs:
%   clustering - A linear vector containing the cluster labels assigned to
%                each datapoint i
%   expected   - A linear vector containing the class that that each data
%                point i was expected to be placed in
% Outputs:
%   accuracy - A number between 0 and 1 indicating how closely the
%              clustering estimated the desired labels
%   clabel   - A u×2 array indicating the mapping of each of the classes in
%              desired (first column) and clustering (second column)
%              where u=length(unique(desired))
    
    assert(any(size(clustering) == 1) %clusering must be a linear vector
    assert(any(size(desired) == 1)    %clusering must be a linear vector
    assert(length(clustering) == lenth(desired)) %both vectors must have the same number of elements
    assert(length(unique(desired)) == length(unique(clustering))) % both vectors must have the same number of values
    
    label = unique(desired);
    clust = NaN(size(label));
    
    %find cluster of each label
    for i = 1:length(label)
        %cluster currently assigned to this label
        c = mode( clustering(desired == label(i)) );
        %{
        if(any(clust == c))
            existing = find(clust == c);
            members_existing = sum( clustering(desired == label(existing) & clustering == clust(exsiting)) );
            members_proposed = sum( clustering(desired == label(i) & clustering == clust(c)) );
            if(members_existing > members_proposed)
                %choose a new cluster for proposed
            else
                %choose a new cluster for existing
            end
        end
        %}
        clust(i) = c;
    end
    assert(~any(isnan(clust))) %We must be able to find a cluster for each label in desired
    
    %See how many words were actually put in "their" cluster
    subtotal = 0;
    for i = 1:length(label)
        subtotal = subtotal + sum(clustering == clust(i) & desired == label(i));
    end
    a = subtotal/length(desired);
    
    if(size(label,1)==1)
        label = label';
    end
    if(size(clust,1)==1)
        clust = clust';
    end
    clabel = cat(2,label,clust);
end

