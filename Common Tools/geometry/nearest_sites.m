function [nearest_A_index, nearest_A_distance] = nearest_sites( ...
    A_coords, B_coords, varargin)
narginchk(2, 3);
if nargin == 3
    scale = varargin{:};
else
    scale = "km";
end
% For each coordinate in B_coords, returns the index of the nearest
% coordinate in A_coords, and the geodetic distance between those points
% with reference to ellipsoid

% If A_coords is an unorganized list of points, each pair of coordinates
% in A_coords and B_coords must be compared to find the closest coordinate
% in A_coords to each coordinate in B_coords. For a
% large list of A_coords/B_coords, this implementation of the brute force
% solution might still be inefficient (M trees could be a solution)

[B_lats, A_lats] = ndgrid(B_coords(:, 1), A_coords(:, 1));
[B_lons, A_lons] = ndgrid(B_coords(:, 2), A_coords(:, 2));

[nearest_A_distance, nearest_A_index] = min(reshape(distance(A_lats(:), ...
    A_lons(:), B_lats(:), B_lons(:), wgs84Ellipsoid(scale)), ...
    [size(B_coords, 1) size(A_coords, 1)]), [], 2);

end