function mid_coords = midpoints(A_coords, B_coords, varargin)
narginchk(2, 3);
% returns the coordinates of the midpoints between each pair of
% coordinates in A_coords, B_coords, where for some positive integer M,
% A_coords/B_coords are Mx2 matrices containing lat/lons in degrees.
if nargin == 3
    mode = varargin{:};
else
    mode = "safe";
end
switch mode
    case "fast" % arithmetic mean of lats of A/B and lons of A/B.
        mid_coords = [(A_coords(:, 1) + B_coords(:, 1))/2 ...
            (A_coords(:, 2) + B_coords(:, 2))/2];
    case "safe" % returns the midpoint of each geodesic path from A to
        % B. Computationally more expensive, but correctly handles
        % pairs of coordinates that are far apart, near the north/south
        % pole, and/or with paths crossing the antimeridian.

        % path lengths and headings from each A to each B.
        [path_length, heading] = distance(A_coords, B_coords, ...
            wgs84Ellipsoid);

        % coordinates of the points from the same headings from each A,
        % but half as far as the distance to each B.
        mid_coords = reckon(A_coords(:, 1), A_coords(:, 2), ...
            path_length/2, heading, wgs84Ellipsoid);
    otherwise
        throw(MException([mfilename ':InvalidArgument'], ...
            'Unimplemented mode specified'))
end
% NOTE: "safe" is sufficiently fast, and should be used by default. "fast"
% is a common way of implementing this function. Issues matching the output
% of other programs might stem from calculating midpoints differently
end
