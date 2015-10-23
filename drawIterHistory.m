function drawIterHistory(xx0,h,pp,filename)
%% Read Me
% drawIterHistory(xx0,h,pp,filename) creates a gif image from the iteration
% history of fmincon.
%
% INPUTS:
%   xx0: The initial ellipse parameters
%   h:   The iterHistory values
%   pp:  Points that are being contained by ellipse
%   filename: Filename of gif [char]

%% Generate GIF of Iteration History
figure
for n = 1:size(h,1)
      draw(xx0,h(n,:),pp)
      drawnow
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if n == 1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
end