function a = TestArgument(x, y)

  if ~exist('y', 'var')
    disp('y does not exist');
    a = x;
  else
    a = x+y
  end

end

