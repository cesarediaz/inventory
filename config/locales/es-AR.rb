{
  :'es-AR' => {

     :faq => {
      :what_are_workstations_module=> "Que tiene el modulo Equipos?",
      :workstations_module_is=> "Es el lugar donde usted puede reunir una computadora mas
                                  un monitor mas una impresora.
                                 Esto le mostrara las estaciones de trabajo que estan
                                 preparadas para trabajar inmediatamente. Esto significa
                                 que un usuario puede utilizar esta maquina para trabajar
                                 ya mismo si es necesario.",

      :which_are_the_rules_to_have_a_workstation => "Cuales son las reglas para tener un equipo?",
      :rules_to_consider_in_a_workstation => "Este debe estar compuesto por una computadora y un monitor.",
      :what_in_statistics_of_workstations => "Que hay en estadisticas para equipos?",
      :workstations_statistics_show => "Esto muestra informacion escrita y grafica para cada lugar
                                        mostrando computadoras, monitores e impresoras que esta solas
                                        como tambien las que son parte de equipos ",

      :what_is_places_module => "Que tiene en opciones de Lugares?",
      :place_module_is => "Este es el modulo donde usted puede agregar diferentes tipos de
                          lugares como depositos, oficinas, aulas, departamentos o salas
                          con un nombre para cada una.",
      :what_can_i_do_there => "Que puedes hacer ahi?",
      :there_you_can => "Ahi puedes observar la lista completa de lugarese, buscar lugares
                         por nombre o por conceptos mas generales como 'oficinas', 'departamentos'
                         , etc. seleccionando estos por descripcion. En la lista por cada lugar
                         usted puede leer informacion acerca del 'Nombre' de lugar, 'Descripcion'
                         , numero de 'computadoras', numero de 'monitores', numero de impresoras
                         y enlaces para descargar archivos xls o pdf ",
     :what_in_statistics_of_places => 'Que puedo encontrar en la opcion de estadisticas?',
     :in_statistics_of_places => 'Ahi puedes ver diferentes graficos acerca de informacion especifica
                                  as el porcentaje de lugares para cada tipo de lugar, porcentajes
                                  de computadoras, monitores o impresoras en cada lugar tambien',

  :what_is_hardware_module => "Que tiene el modulo Hardware?",
  :in_hardware_has => "Ahí encontrara todos los tipos de hardware incluidos en el sitema.
                       Si algun tipo de hardware no esta presente deberia ser agregado
                       desarrollando esa parte del sistema.",

  :what_in_submodule_computers => 'Que tiene en computadoras?',
  :in_computers_has => "Allí es posigle observar una lista con todas las computadoras
                        por cada lugar(Disponibles mas No Disponibles), otra lista con solo
                        las Disponibles, una con solo las No Disponibles y otra opcion para
                        ver estadisticas con respecto a estos datos.",

  :what_in_submodule_motherboards => 'Que tiene en placas madres?',
  :in_motherboards_has => 'Ahí es posible observar una lista con todas las placas madres
                           indicando en que computadora esta siendo utilizada
                           o solo la informacion de la placa madre en caso de que no este
                           siendo utilizada.',

  :what_in_submodule_harddisks => 'Que tiene en discos rigidos?',
  :in_harddisks_has => 'Ahí es posible observar una lista con todas los discos rigidos por
                        cada computadora si esta siendo usada por una computadora o sin un
                        nombre de PC en caso de que este continue sin uso.',

  :what_in_submodule_memories => 'Que tiene en memorias?',
  :in_memories_has => 'Ahí es posible observar una lista con todas las memorias para
                       cada computadora si esta siendo usada por una computadora o sin
                       el detalle del nombre de PC en caso de que no este usandose.',

  :what_in_submodule_cds => 'Que tiene en cds?',
  :in_cds_has => 'Ahí es posible observar una lista con todas los lectoras/grabadoras de cds
                  por cada computadora si esta esta siendo usada por una computadora o sin un
                  nombre de computadora en caso de que no este utilizandose.',

  :what_in_submodule_dvds => 'Que tiene en dvds?',
  :in_dvds_has => 'Ahí es posible observar una lista con todas los lectoras/grabadoras de dvds
                  por cada computadora si esta esta siendo usada por una computadora o sin un
                  nombre de computadora en caso de que no este utilizandose.',

  :what_in_submodule_screens => 'Que tiene en monitores?',
  :in_screens_has => 'Ahí es posible observar una lista con todas los monitores mostrando
                      informacion acerca de donde esta ubicado y si es parte de un equipo.',

  :what_in_submodule_printers => 'Que tiene en impresoras?',
  :in_printers_has => 'Ahí es posible observar una lista con todas las impresoras mostrando
                      informacion acerca de donde esta ubicada y si es parte de un equipo.',

  :what_is_mark_module => "Que tiene el modulo Marcas?",
  :in_mark_has => "Ahí encontraras todos los nombres de marcas presentes entre el
                   hardware que usted tiene en el lugar.",

  :what_is_company_module => "Que tiene en el modulo Empresas?",
  :in_company_has => "Ahí encontrara la lista completa de empresas las cuales vendieron lo
                     que usted tiene en su lugar. Otra informacion extra son los datos
                     de contacto como el telefono, la dirección o el email de la empresa.
                     Si usted completa este formulario con la informacion de direccion
                     (ciudad, calle, número) podra obtener un mapa para conocer la direccion
                     exacta de forma visual de la compania que se trate.",

  :what_is_bill_module => "Que hay en el modulo Facturacion?",
  :in_bill_has => "Ahí puede encontrar todas las facturas donde esta escrito en detalle
                   que fue comprado y en que fecha.",

  :what_is_pages_module => "Que hay en el modulo Paginas?",
  :in_pages_has => "Ahí usted puede agregar nuevas paginas para el frontend de su sitio
                    como tambien paginas internas",
},

  :models => {
    :model => 'Model',
    :mark => 'Mark',
    :new => 'Agregar modelo',
    :description => 'Descripcion',
    :mark => 'Marca',
},

    :bill => {
    :code => 'Nro de factura',
    :company => 'Empresa',
    :date => 'Fecha de facturacion',
    :edit => "Modificar",
    :create => "Agregar",
    :new => "Agregar nueva factura",
    :show => "Ver",
    :select_by_company => "Seleccione listado por empresa",
   },

  :company => {
    :name => "Nombre",
    :street => "Calle",
    :number => "Numero",
    :city => "Ciudad",
    :country => "Pais",
    :contact => "Contacto",
    :address => "Direccion",
    :phone => "Telefono",
    :fax => "Fax",
    :email => "Email",
    :edit => "Modificar",
    :create => "Agregar",
    :new => "Agregar nueva empresa"},

  :user =>{
    :confirm_password => "Confirmar clave",
    :password => "Clave",
    :language => "Idioma",
    :edit => "Editar",
  },

  :pages =>{
    :name_page => "Nombre de la pagina",
    :content_page => "Contenido de la pagina",
    :front_end? => "Mostrar al frente",
  },

  :inventory => {
    :title => "Inventario de hardware",
  },

  :workstations => {
    :computer => "Pc",
    :screen => "Monitor",
    :printer => "Impresora",
    :action => "Accion",
    :new => "Agregar nuevo equipo",
    :create => "Agregar",
    :edit => "Modificar",
    :place => "Lugar",
    :select_a_place => "Seleccione un lugar",
    :list_of_equipments => "Listado de equipos en",
    :back => "Regresar"
  },

  :computers => {
    :title => "Computadoras",
    :name => "Nombre",
    :stats_paragraph => "En numeros de pc",
    :available => "Disponibles",
    :unavailable => "No disponibles",
    :all  => "Total",
    :new => "Agregar nueva pc",
    :create => "Agregar",
    :edit => "Editar",
    :harddisk => "Disco rigido",
    :memory => "Memoria",
    :place => "Lugar",
    :workstation? => "Puesto?",
    :y => "Si",
    :not => "No",
    :bill => "Factura",
    :inventory_register => 'Registro inventario',
  },
  :places => {
    :title => "Lugar",
    :computer => "Computadoras",
    :screen => "Monitores",
    :printer => "Impresoras",
    :description => "Descripcion",
    :workstations => "Equipos",
    :name => "Nombre",
    :edit => "Editar",
    :create => "Agregar",
    :place => "Lugar",
    :select_type_of_places => "Seleccione diferentes lugares por descripcion",
    :select_one => "Seleccione una opcion",
    :new => "Agregar lugar",
    :all => "Todos",
    :departments => "Departamentos",
    :offices => "Oficinas",
    :rooms => "Salas",
    :classrooms => "Aulas",
    :stores => "Depositos",
    :confirm => "Estas seguro de eliminar este registro?",
    :graphic_stats_paragraph => "Un grafico en porcentajes de lugares",
    :graphic_stats_in_numbers => "En numeros de lugares",
    :show => "Ver",
 },

  :motherboards => {
    :model => "Modelo",
    :sn => "Numero de Serie",
    :mark => "Marca",
    :new => "Nueva placa madre",
    :computer => "En pc",
    :bill => "Factura",
    :inventory_register => 'Registro inventario',
  },

  :harddisks => {
    :model => "Modelo",
    :sn => "Numero de Serie",
    :size  => "Capacidad",
    :mark => "Marca",
    :bill => "Factura",
    :inventory_register => 'Registro inventario',
  },

  :memories => {
    :model => "Modelo",
    :sn => "Numero de Serie",
    :size  => "Capacidad",
    :mark => "Marca",
    :bill => "Factura",
    :inventory_register => 'Registro inventario',
  },

  :dvds => {
    :model => "Modelo",
    :sn => "Numero de Serie",
    :mark => "Marca",
    :burn => "Grabadora",
    :bill => "Factura",
    :inventory_register => 'Registro inventario',
  },

  :cds => {
    :model => "Modelo",
    :sn => "Numero de Serie",
    :mark => "Marca",
    :burn => "Grabadora",
    :bill => "Factura",
    :inventory_register => 'Registro inventario',
  },

  :screens => {
    :title => "Monitores",
    :model => "Modelo",
    :sn => "Numero de Serie",
    :mark => "Marca",
    :workstation? => "Puesto?",
    :bill => "Factura",
    :inventory_register => 'Registro inventario',
  },

  :printers => {
    :title => "Impresoras",
    :model => "Modelo",
    :sn => "Numero de Serie",
    :mark => "Marca",
    :workstation? => "Puesto?",
    :bill => "Factura",
    :inventory_register => 'Registro inventario',
  },

  :marks => {
    :mark => "Marca",
    :new => "Nueva",
    :edit  => "Editar",
    :show  => "Ver",
    :destroy => "Eliminar",
    :inventory_register => 'Registro inventario',
  },

  :common_actions => {
    :actions => "Acciones",
    :edit => "Modificar",
    :destroy => "Eliminar",
    :show => "Ver",
    :create => "Agregar",
    :back => "Regresar",
    :top_page => "Ir al inicio de pagina",
    :download_pdf => "Descargar un archivo pdf",
    :download => "Descargar un archivo xls",
    :download_all => "Descargar todo en un archivo xls",
    :show_hide => "Mostrar/Ocultar",
    :show_hide_advice => "Mostrar/Ocultar aviso",
    :hide_advice => "Ocultar aviso",
    :report_of => "Informe de ",
  },


:help_phrases => {
  :in_workstation => "Este dispositivo esta asignado en una estacion de trabajo.
                    Para cambiar el atributo Lugar debe ir a la seccion Equipos.",
  :stats_in_place => "Libre: equipos que no forman parte de una estacion de trabajo.
                    En equipos: integran una estacion de trabajo",
  :msg_text => 'Debes poner un guion (\'-\') donde deberias poner texto si no conoces esos datos',
  :msg_number =>  'Debes poner un numero cero(\'0\') donde deberias poner datos numericos
                   si no conoces esos datos',
  :msg_email => 'Si no tienes una direccion de email definida completa con un email ficticio
                como el siguiente ejemplo, without@email.com',
  :accesskeys_firefox => 'By Firefox pressing',
  :accesskeys_iexplorer => 'By Internet Explorer pressing',
  :accesskeys_chrome => 'By Chrone pressing',
  :do_you_want_destroy_a_workstation => 'Es parte de una estacion de trabajo,
  si eliminas esto la estacion de trabajo debe desmantelarse,
  estas seguro de que es eso lo que queres?',
},


 :front_end => {
  :digital_data => 'Informacion digital',
  :getting_digital_data => 'Obteniendo informacion digital',
  :you_can_with_digital_data => 'puedes descargar archivos pdf u hojas de calculo
  para tener un listado completo de dispositivos en su empresa o donde quiera
  que este. Estos pueden ser listados de lugares especificos tal como una oficina
  o  una completa descripcion de una computadora con todos sus componentes internos.',

  :settings => 'Configuraciones',
},


 :search => {
   :label => "Buscar",
},

 :stats => {
  :available => "Disponibles",
  :unavailable => "En uso",
  :alone => "Libre",
  :workstation => "En equipos",
  :places_statistic => "Aqui puede ver la distribucion en tipos de lugares",
  :pc_statistic => "Aqui puede ver la distribucion de computadoras por lugares",
  :screens_statistic => "Aqui puede ver la distribucion de monitores por lugares",
  :printers_statistic => "Aqui puede ver la distribucion de impresoras por lugares"
},

 :phrases => {
  :list_of  => "Lista de ",
  :units => " unidades ",
  :has => " tiene ",
  :y => "si",
  :n => "no",
  :result_search => 'Resultado de busqueda',
  :successfully => "El registro fue satisfactoriamente creado",
  :by => " por "
},

:flash => {
  :succefully => "Logueado satisfactoriamente.",
  :error => "No se puede logear. Corrija su usuario o clave en intente nuevamente"
},


 :menu => {
   :models => "Modelos",
   :list_models =>  "Listar modelos",
   :new_model => "Nuevo modelo",

   :pages => "Paginas",
   :list_pages => "Listar paginas",
   :new_page => "Nueva pagina",

   :companies  => "Empresas",
   :list_companies  => "Listar empresas",
   :company_new  => "Nueva",

   :bills  => "Facturas",
   :list_bills  => "Listar facturas",
   :bill_new  => "Nuevo factura",

   :users => "Usuarios",
   :users_list => "Lista de usuarios",
   :users_history => "Historial",
   :users_admin? => "Administrador?",
   :user => "Usuario : ",

   :account  => "Su cuenta",
   :new_account  => "Nueva cuenta",
   :account_edit  => "Editar datos de su cuenta",

   :workstations  => "Equipos",
   :list_workstations  => "Listar los equipos",
   :new  => "Nuevo",
   :stats_workstations  => "Estadisticas",
   :change_place => 'Cambiar ubicacion',

   :places  => "Lugares",
   :list_places  => "Lista de lugares",
   :new_place  => "Nuevo",
   :stats_places  => "Estadisticas",

   :computers  => "Computadoras",
   :list_computers  => "Listar todas las computadoras",
   :new_computer  => "Nueva",
   :availables_computers  => "Disponibles",
   :unavailables_computers  => "No disponibles",
   :stats_computers => "Estadisticas",

    #MotherBoards
   :motherboards  => "Placa madre",
   :list_motherboards  => "Listar placas madre",
   :new_motherboard  => "Nueva",

    #Harddisks
   :harddisks  => "Disco rigido",
   :list_harddisks  => "Listar discos",
   :new_harddisk  => "Nuevo",

   #Memories
   :memories  => "Memorias",
   :list_memories  => "Listar memorias",
   :new_memorie  => "Nuevo",

   #Dvds
   :dvds  => "R/W dvds",
   :list_dvds  => "Listar dispositivos",
   :new_dvd  => "Nuevo",

   #Cds
   :cds  => "R/W cds",
   :list_cds  => "Listar dispositivos",
   :new_cd  => "Nuevo",

   #Screens
   :screens  => "Monitores",
   :list_screens  => "Listar monitores",
   :new_screen  => "Nuevo",

   #Printers
   :printers  => "Impresoras",
   :list_printers  => "Listar impresoras",
   :new_printer  => "Nuevo",

   #Marks
   :marks  => "Marcas",
   :list_marks  => "Listar marcas",
   :new_mark  => "Nueva",

   #Login
   :login  => "Ingresar",
   :logout  => "Salir",
   :in => "Escriba su usuario y clave para ingresar a la aplicacion",
   :login => 'User',
   :password => 'Password',


   #FrontEnd
   :home => 'Home'

},


    :date => {
      :formats => {
        :default => "%e/%m/%Y",
        :short => "%e %b",
        :long => "%e de %B de %Y",
        :only_day => "%e"
      },
      :day_names => %w(Domingo Lunes Martes Miércoles Jueves Viernes Sábado),
      :abbr_day_names => %w(Dom Lun Mar Mie Jue Vie Sab),
      :month_names => [nil] + %w(Enero Febrero Marzo Abril Mayo Junio Julio Agosto Setiembre Octubre Noviembre Diciembre),
      :abbr_month_names => [nil] + %w(Ene Feb Mar Abr May Jun Jul Ago Set Oct Nov Dic),
      :order => [:day, :month, :year]
    },
    :time => {
      :formats => {
        :default => "%A, %e de %B de %Y, %H:%M hs",
        :time => "%H:%M hs",
        :short => "%e/%m, %H:%M hs",
        :long => "%A, %e de %B de %Y, %H:%M hs",
        :only_second => "%S"
      },
      :datetime => {
        :formats => {
          :default => "%d/%m/%Y-%dT%H:%M:%S%Z"
        }
      },
      :time_with_zone => {
        :formats => {
          :default => lambda { |time| "%Y-%m-%d %H:%M:%S #{time.formatted_offset(false, 'UTC')}" }
        }
      },
      :am => 'am',
      :pm => 'pm'
    },
    # date helper distancia en palabras
    #NOTE: Pluralization rules have changed! Rather than simply submitting an array, i18n now allows for a hash with the keys:
    # :zero, :one & :other - FUNKY (but a pain to find...)!
    :datetime => {
      :distance_in_words => {
        :half_a_minute => 'medio minuto',
        :less_than_x_seconds => {:zero => 'menos de 1 segundo', :one => 'menos de 1 segundo', :other => 'menos de {{count}} segundos'},
        :x_seconds => {:one => '1 second', :other => '{{count}} seconds'},
        :less_than_x_minutes => {:zero => 'menos de 1 minuto', :one => 'menos de 1 minuto', :other => 'menos de {{count}} minutos'},
        :x_minutes => {:one => "1 minuto", :other => "{{count}} minutos"},
        :about_x_hours => {:one => 'aproximadamente 1 hora', :other => 'aproximadamente {{count}} horas'},
        :x_days => {:one => '1 día', :other => '{{count}} días'},
        :about_x_months => {:one => 'aproximandamente 1 mes', :other => 'aproximadamente {{count}} mes'},
        :x_months => {:one => '1 month', :other => '{{count}} mes'},
        :about_x_years => {:one => 'aproximadamente 1 año', :other => 'aproximadamente {{count}} años'},
        :over_x_years => {:one => 'más de 1 año', :other => 'más de {{count}} años'}
      }
    },

    # numbers
    :number => {
      :format => {
        :precision => 3,
        :separator => ',',
        :delimiter => '.'
      },
      :currency => {
        :format => {
          :unit => '$',
          :precision => 2,
          :format => '%u %n'
        }
      }
    },

    # Active Record
    :activerecord => {
      :errors => {
        :template => {
          :header => {
            :one => "{{model}} no pudo guardarse: 1 error",
            :other => "{{model}}: {{count}} errores."
          },
          :body => "Por favor revise los campos siguientes:"
        },
        :messages => {
          :inclusion => "no está incluido en la lista",
          :exclusion => "no está disponible",
          :invalid => "no es válido",
          :confirmation => "no coincide con la confirmación",
          :accepted => "debe ser aceptado",
          :empty => "no puede estar vacío",
          :blank => "no puede estar en blanco",
          :too_long => "es demasiado largo (no más de {{count}} caracteres)",
          :too_short => "es demasiado corto (no menos de {{count}} caracteres)",
          :wrong_length => "no tiene la longitud correcta (debe ser de {{count}} caracteres)",
          :taken => "no está disponible",
          :not_a_number => "no es un número",
          :greater_than => "debe ser mayor a {{count}}",
          :greater_than_or_equal_to => "debe ser mayor o igual a {{count}}",
          :equal_to => "debe ser igual a {{count}}",
          :less_than => "debe ser menor que {{count}}",
          :less_than_or_equal_to => "debe ser menor o igual que {{count}}",
          :odd => "debe ser par",
          :even => "debe ser impar"
        }
      }
    }
  }
}

