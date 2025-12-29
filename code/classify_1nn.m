function class = classify_1nn(test, train, labels)
% CLASSIFY_1NN Simple 1-Nearest Neighbor classifier.
%   Used as a replacement for the missing 'classify' function in some
%   environments (like GNU Octave).
%
%   Usage:
%   class = classify_1nn(test, train, labels)

D = distanceMatrix(test, train);
[~, min_idx] = min(D, [], 2);
class = labels(min_idx);
end
