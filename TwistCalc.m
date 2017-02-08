function [ Pretwist ] = TwistCalc( rootPitch, twistTotal, nodes )
%twistCalc determines the pitch of the blade at each span-wise node
%   rootPitch is the blade pitch angle at the blade root [degrees]
%   twistTotal is the change in pitch angle from root to tip [degrees]
%   nodes is the number of span-wise nodes from root to tip
%   Pretwist is a nodes x 2 matrix. The first column is pretwist in degrees
%                                   The second column is the pretwist in radians

Pretwist = zeros (nodes,2);
PretwistDegrees = zeros (nodes, 1);
PretwistRadians = zeros (nodes, 1);
twistRate = twistTotal/(nodes - 1);

for i = 1:nodes
    PretwistDegrees(i) = rootPitch + twistRate*(i-1);
    PretwistRadians(i) = PretwistDegrees(i) * 3.14159 / 180;
end

Pretwist = [PretwistDegrees PretwistRadians]

end