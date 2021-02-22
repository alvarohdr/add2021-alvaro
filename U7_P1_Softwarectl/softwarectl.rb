#!/usr/bin/env ruby

# Programa de control de software
# Creado por Álvaro Hernández Rocío
# Usuario github: alvarohdr
# Fecha de creación: 11/02/2021

# PASO 1: Si el script se ejecuta sin parámetros, se mostrará un mensaje aconsejando usar la opción "--help" para ver la ayuda.

if ARGV[0].nil?
    puts "Softwarectl: Falta un parámetro."
    puts "Prueba 'softwarectl --help' para más información."
    exit 1
end

# PASO 2: Si el script se ejecuta con el parámetro --help se mostrará la ayuda.

if ARGV[0] == "--help"
    puts "Usage:"
    puts "  systemctml [OPTIONS] [FILENAME]"
    puts "Options:"
    puts "  --help, mostrar esta ayuda."
    puts "  --version, mostrar información sobre el autor del script y fecha de creacion."
    puts "  --status FILENAME, comprueba si puede instalar/desintalar."
    puts "  --run FILENAME, instala/desinstala el software indicado."
    puts "Description:"
    puts ""
    puts "  Este script se encarga de instalar/desinstalar"
    puts "  el software indicado en el fichero FILENAME."
    puts "  Ejemplo de FILENAME:"
    puts "      tree:install"
    puts "      nmap:install"
    puts "      atomix:remove"
    exit 0
end

# PASO 3: Si el script se ejecuta con la opción --version, se muestra en pantalla información del autor del script y la fecha de creación.

if ARGV[0] == "--version"
    puts "Script creado por: alvarohdr"
    puts "11/02/2021"
    puts "Versión: Softwarectl 1.0"
    exit 0
end

# PASO 4: Si el script se ejecuta con la opción --status FILENAME, entonces se lee el contenido del fichero FILENAME, y para cada PACKAGENAME 
# se muestra en pantalla su estado actual. Esto es, (I) installed o (U) uninstalled.

if ARGV[0] == "--status"
    input = `cat #{ARGV[1]}`.split("\n")
    input.each do |a|
        b = a.split(":")
        c = `whereis #{b[0]} |grep bin |wc -l`.chop
        if c != "0"
            puts "#{b[0]}: (I) installed"
        else
            puts "#{b[0]}: (U) uninstalled"
        end
    end
    exit 0
end

# PASO 5: Si el script se ejecuta con la opción --run FILENAME:
#   Primero se comprueba que se seamos el usuario root. En caso contrario se mostrará un mensaje de advertencia en pantalla y se finaliza 
#       el script con error (exit 1).
#   Segundo se lee el contenido del fichero FILENAME, y para cada PACKAGENAME se procede a ejecutar la acción asociada, que puede ser "install" o "remove".

if ARGV[0] == "--run"
    usuario = `whoami`.chop
    if usuario != "root"
        puts "Debes ser root para ejecutar este comando"
        exit 1
    else  
        input = `cat #{ARGV[1]}`.split("\n")
        input.each do |a|
            b = a.split(":")
            c = `whereis #{b[0]} |grep bin |wc -l`.chop
            
            if (c != "0" && b[1] == "install")
                puts "El paquete #{b[0]} no se puede instalar porque ya está instalado."
            end
            if (c == "0" && b[1] == "remove")
                puts "El paquete #{b[0]} no se puede desinstalar porque no se ha encontrado."
            end
            if (c != "0" && b[1] == "remove")
                puts "Desinstalando el paquete #{b[0]}..."
                system ("zypper remove -y #{b[0]}")
            end
            if (c == "0" && b[1] == "install")
                puts "Instalando el paquete #{b[0]}..."
                system ("zypper install -y #{b[0]}")
            end
        end
    end
    exit 0
end