% Copyright Colin O'Flynn, 2011. All rights reserved.
% http://www.newae.com
%
% Redistribution and use in source and binary forms, with or without modification, are
% permitted provided that the following conditions are met:
% 
%    1. Redistributions of source code must retain the above copyright notice, this list of
%       conditions and the following disclaimer.
% 
%    2. Redistributions in binary form must reproduce the above copyright notice, this list
%       of conditions and the following disclaimer in the documentation and/or other materials
%       provided with the distribution.
% 
% THIS SOFTWARE IS PROVIDED BY COLIN O'FLYNN ''AS IS'' AND ANY EXPRESS OR IMPLIED
% WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
% FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL COLIN O'FLYNN OR
% CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
% ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
% NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
% ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
function [output] = q3_interleaver(rows, cols)

linput = rows*cols;

input = [0:linput-1];

output = zeros(1,length(input));

input = reshape(input, cols, rows)';

j = 1;
for startingrow=1:rows;        
    %Start at left point in each row...
    col = 1;
    row = startingrow;   
    while row > 0 && col <= cols
        output(j) = input(row,col);
        col = col+1;
        row = row-1;
        j = 1+j;
    end      
end
    
for startingcol=2:cols;            
    %Do bottom row all way along
    col = startingcol;    
    row = rows;
    while row > 0 && col <= cols
        output(j) = input(row,col);
        col = col+1;
        row = row-1;
        j = 1+j;
    end      
end   
