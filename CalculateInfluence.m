function [] = CalculateInfluence(Derivative, Range, TrimValue)
    global EvaluateTable idx epsilon;
    idx = idx + 1;
    if TrimValue == 0
        TrimValue = 1e-10; % 避免除以0的情况，只要Derivative不为0，影响就应该显著
    end
 
    zeta = abs(Derivative * Range / TrimValue);
    % fprintf('Factor of Influence: %.8f', zeta);
    if(zeta >= epsilon)
        % fprintf(' -- Significant Influence');
        EvaluateTable(idx) = 1;
    end
    % fprintf('\n');
end