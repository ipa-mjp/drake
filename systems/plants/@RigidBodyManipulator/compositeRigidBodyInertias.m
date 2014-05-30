function [crbs, dcrbs] = compositeRigidBodyInertias(manipulator, inertias_world, dinertias_world)
% computes composite rigid body inertias expressed in world frame

compute_gradients = nargout > 1;

NB = length(inertias_world);
crbs = inertias_world;

if compute_gradients
  if nargin < 3
    error('must pass in dinertias_world argument to compute gradient output');
  end
  dcrbs = dinertias_world;
end

for i = NB : -1 : 2
  body = manipulator.body(i);
  crbs{body.parent} = crbs{body.parent} + crbs{i};
  if compute_gradients
    dcrbs{body.parent} = dcrbs{body.parent} + dcrbs{i};
  end
end
end