function ratio = RatioRentabilidad( poblacion, Dat, D, n )
%RATIORENTABILIDAD Summary of this function goes here
%   Calcula el ratio de rentabilidad de añadir una nueva ITV en poblacion
%   Argumentos:
%   - poblacion     Población en la que se coloca la ITV
%   - inspecciones  Nº de inspecciones que se realizarían en la nueva ITV
%   - Dat           Datos

    % Criterio: Mayor ratio de rentabilidad
    inspecciones = PronosticarDemanda(poblacion, Dat, D, n);
    param_rentabilidad = CalcularRentabilidad(poblacion, Dat);
    ratio = inspecciones / param_rentabilidad;


    % Criterio: Reducir máximo número de kilómetros recorridos
    



end

