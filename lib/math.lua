function math.lerp(a, b, k)
  return a * (1 - k) + b * k
end

function sign(x)
  if x > 0 then
    return 1
  elseif x < 0 then
    return -1
  end
  return 0
end

function nearest(x, a, b)
  if math.abs(a - x) < abs(b - x) then
    return a
  end
  return b
end
