%Constants for Tip Shape Trials
twistRate=-12;
tipTaperRatio = 2;
tipAnhedral = 20;
tipSweep = 10;
AoARoot=0;
Cmain=0.077;
spanNodes = 17;
tipNodes = 6;

chordNodes = 9;

bladeLength = 1.19;
tipLength = 0.2;

%%%%%%%%%%%%%%% Calculations %%%%%%%%%%%%%%%%%%
bladeNodes = spanNodes - (tipNodes - 1);                    
deltaYblade = (bladeLength - tipLength) / (bladeNodes - 1); % Blade Node Spacing
deltaYtip = tipLength/(tipNodes - 1);                       % Tip Node Spacing
deltaX = 1 / (chordNodes - 1);

yDistrBlade = zeros ((spanNodes - tipNodes), 1);            % Blade Node Distribution Memory Allocation
yDistrTip = zeros (tipNodes, 1);                            % Tip Node Distribution Memory Allocation
xDistr = zeros (chordNodes, 1);                             % Chord Node Distribution Memory Allocation

for i = 2:chordNodes
    xDistr(i) = xDistr(i-1) + deltaX;
end

for i = 2:bladeNodes
    yDistrBlade(i) = yDistrBlade(i-1) + deltaYblade;
end

yDistrTip(1) = yDistrBlade(bladeNodes);

for i = 2:tipNodes
    yDistrTip(i) = yDistrTip(i-1) + deltaYtip;
end

deltaYblade
yDistrBlade
deltaYtip
yDistrTip
xDistr
    
