function square_dist = square_dist(U, v)
square_dist = sqrt(sum(bsxfun(@minus, U, v).^2, 2))';
end
