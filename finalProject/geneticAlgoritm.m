function optimized_positions = geneticAlgoritm(detection_function, fs)
    options = optimoptions('ga', 'MaxGenerations', 1000, 'Display', 'off');
    num_peaks = 2;
    lb = zeros(1, num_peaks);
    ub = ones(1, num_peaks) * (length(detection_function) / fs);
    result = ga(@(params) cost_function(params, detection_function, fs), num_peaks, [], [], [], [], lb, ub, [], options);
    optimized_positions = round(result * fs);
end
function cost = cost_function(params, detection_function, fs)
    positions = round(params * fs);
    positions = max(min(positions, length(detection_function)), 1);
    selected_peaks = detection_function(positions);
    cost = -sum(selected_peaks);
end
