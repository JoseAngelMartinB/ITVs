function Visualizacion( Dat, nuevas_itv, n )
%VISUALIZACION 
%   Visualizar y exportar solucion


    % Guardar solución en tabla LaTeX
    % Provincia | Población | Tipología | Índice de mejora

    % Situación actual

    % Situación tras apertura de nuevas ITVs





    % Exportar regiones de Voronoi
    itv_tot = [];
    for i=1:n
        if Dat(i,4) > 0 % Hay una ITV en la ciudad
            itv_tot = [itv_tot i];
        end
    end
    
    voronoi(Dat(itv_tot, 2), Dat(itv_tot, 1));
    hold;
    
    for i=1:n
        if Dat(i,4) > 0
            plot(Dat(i,2),Dat(i,1),'o')
        else
            plot(Dat(i,2),Dat(i,1),'*')
        end
    end
    
    
    
    
    
    
    
    
    % Prueba: Dibujar mapa con voronoi y ciudades
%     voronoi(Dat(:,2),Dat(:,1))
%     hold
%     for i=1:n
%         plot(Dat(i,2),Dat(i,1),'*')
%     end

end

