function varargout = terrain_lookup(get_elev, varargin)
% most of the logic in the inner function
% formatting tool, so that cells can be passed as arguments, and the output
% behaves as expected without causing a problem
% this function is more general than its naming implies
sep = ones(size(varargin));
argclass = @(c)class(c);
cells_of_coords = strcmp("cell", string(cellfun(argclass, varargin, ...
    'UniformOutput', false))); 
sep(cells_of_coords) = cellfun(@nrows, varargin(cells_of_coords));
if any(cells_of_coords)
    inner_input = cat(1, varargin{:});
else
    inner_input = varargin;
end
varargout = mat2cell(inner_terrain_lookup( ...
    get_elev, inner_input), sep);
unpack = @(c)c{:};
varargout(~cells_of_coords) = cellfun(unpack, ...
    varargout(~cells_of_coords), 'UniformOutput', false);
end
function out = inner_terrain_lookup(get_elev, inargs)
% getting terrain elevation from lats/lons is computationally expensive.
% This function takes a function pointer get_elev to a library function for
% getting terrain elevation, and an arbitrary number of lists of
% coordinates. It calls get_elev on all coordinates in all lists after
% combining them into a single sorted list. The resulting elevations are
% decollated and distributed to outputs corresponding to each input list.

% This allows terrain elevation calls in unrelated contexts to be batched
% and processed together, in a manner such that an implementation of
% get_elev will not need to repeatedly load/unload the same geographic data
% for coordinates that are close together.
% Logically,
% A_elev = get_elev(A_coords);
% B_elev = get_elev(B_coords);
% is equivalent to 
% [A_elev, B_elev] = terrain_lookup(get_elev, A_coords, B_coords);
% But the latter is possibly significantly faster
sep = cellfun(@nrows, inargs);
[coords, index] = sortrows(cat(1, inargs{:}));
coord_sorted_elev = get_elev(coords);
elev(index) = coord_sorted_elev;
out = mat2cell(elev', sep);
end
function n = nrows(arr)
n = size(arr, 1);
end