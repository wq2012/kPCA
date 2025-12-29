function t = is_octave()
% IS_OCTAVE Check if the environment is GNU Octave.
%
%   Usage:
%   t = is_octave()
%
%   Output:
%   t: True if running in Octave, false otherwise.

t = (exist('OCTAVE_VERSION', 'builtin') > 0);
end
