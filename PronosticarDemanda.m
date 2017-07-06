function inspecciones = PronosticarDemanda( poblacion, Dat, D, n )
%PRONOSTICADEMANDA 
%   Calcula el número de inspecciones que se realizarían si se coloca una
%   ITV.
%   Argumentos:
%   - poblacion     Población en la que se coloca la ITV
%   - Dat           Datos
%   - D             Distancia entre poblaciones
%   - n             Número de poblaciones

    inspecciones = 0;
    Dat(poblacion,4) = 1; % Se añade una ITV a esta población
    pob_con_itv = find(Dat(:,4) > 0);

    for j = 1:n
        D_min = min(D(j, [Dat(:,4) > 0])); % Distancia a ITV más cecana
        ITV_cercana = find(D(j, [Dat(:,4) > 0]) == D_min);
        poblacion_ITV_cercana = pob_con_itv(ITV_cercana);

        if poblacion_ITV_cercana == poblacion
            inspecciones = inspecciones + Dat(poblacion_ITV_cercana, 7);
        end
    end

end

