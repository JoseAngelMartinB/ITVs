function param_rentabilidad = CalcularRentabilidad( poblacion, Dat )
%CALCULARRENTABILIDAD 
%   Calcula el parametro de rentabilidad para una ITV en la población dada
%   Argumentos:
%   - poblacion     Población en la que se coloca la ITV
%   - Dat           Datos

    if Dat(poblacion,6) == 1 % Población admite ITV de proximidad
        param_rentabilidad = 17000;
    else % Población solo admite ITV convencional
        param_rentabilidad = 23000;
    end

end

