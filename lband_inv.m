function Z = lband_inv(S,L)
%This function finds an L-banded approximate inverse for square
%matrix S.

Z = zeros(size(S));
top = 1;
bot = L + 1;
while bot <= size(S,1)
    Z(top:bot,top:bot) = Z(top:bot,top:bot)...
        + inv(S(top:bot,top:bot));
    top = top + 1;
    if bot == size(S,1)
        break
    end
    Z(top:bot,top:bot) = Z(top:bot,top:bot)...
        - inv(S(top:bot,top:bot));
    bot = bot + 1;
end
    