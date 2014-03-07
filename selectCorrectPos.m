  function i = selectCorrectPos(i, anaPm)
    if i == 1
        i = 2;
    elseif i >= length(anaPm) - 1
        i = length(anaPm) - 2;
    end
  end