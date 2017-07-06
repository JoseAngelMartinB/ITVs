function [nuevas_itv, Dat, n_eliminadas] = QuitarITVs( Dat, D, n, nuevas_itv )
%QUITARITVS 
%   Elimina las ITVs con ratio de rentabilidad inferior a 1.
%   Argumentos:
%   - Dat           Datos
%   - D             Distancia entre poblaciones
%   - n             Número de poblaciones
%   - nuevas_itv    Nuevas ITVs añadidas

    viabilidad_pob = zeros(1, n); % Al comienzo ninguna población es viable
    n_eliminadas = 0;
    continuar = 1;
    
    while continuar == 1
        peor_ratio = Inf;
        peor_ciudad = -1;
        peor_i = -1;
        [~ , n_nuevas_itv] = size(nuevas_itv);         

        for i = 1:n_nuevas_itv
            ciudad = nuevas_itv(i);
            
            if viabilidad_pob(ciudad) == 0

                % Calcular nº inspecciones de la ITV
                inspecciones = PronosticarDemanda(ciudad, Dat, D, n);

                ratio = RatioRentabilidad(ciudad, inspecciones, Dat);

                if ratio < 1 && ratio < peor_ratio
                   peor_ratio = ratio;
                   peor_ciudad = ciudad;   
                   peor_i = i;
                end
                
                if ratio >= 1 % La ITV de esta ciudad es viable
                    viabilidad_pob(ciudad) = 1;
                end
 
            end
             
             
        end 
        
        if peor_ciudad > 0
            Dat(peor_ciudad,4) = 0; % Se quita la ITV de esta población
            nuevas_itv(peor_i) = [];
            n_eliminadas = n_eliminadas + 1;
            
            fprintf('\tSe ha eliminado la ITV de la población %d con ratio %d.\n', peor_ciudad, peor_ratio);
        else
            continuar = 0;
        end        
    end
end

