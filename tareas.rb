require 'sinatra'
require 'sinatra/reloader' if development?
require 'make_todo'

seleccionadas = []
frases=["Sólo falta el tiempo a quien no sabe aprovecharlo – Gaspar Melchor de Jovellanos", "Tengo un día. Si lo sé aprovechar, tengo un tesoro - Gabriela Mistral", "La vida es muy peligrosa. No por las personas que hacen el mal, sino por las que se sientan a ver lo que pasa - Albert Einstein", "Nunca te olvides de sonreír, porque el día en que no sonrías será un día perdido - Charles Chaplin", "Dale a cada día la posibilidad de convertirse en el mejor día de tu vida - Autor desconocido", "La vida es aquello que te va sucediendo mientras te empeñas en hacer otros planes – John Lennon", "No puedes detener la primavera, pero la puedes aprovechar al máximo - Friedrich Hebbel", "Aprovecha el día.  No dejes que termine sin haber crecido un poco, sin haber sido un poco más feliz, sin haber alimentado tus sueños - Walt Whitman", "Vive como si este fuera el último día de tu vida, porque el mañana es inseguro, el ayer no te pertenece y solamente el hoy es tuyo - Autor desconocido"]

get '/' do
  @frases= frases
  @nfrase=rand(frases.length)
  puts "RANDOM: #{@nfrase}"
  #puts "TAREAS: #{Tarea.all}" #######################
  #Tarea.create("Sacar a Ramon") ############
  #puts "TAREAS: #{Tarea.all}" #######################
  erb :index
end
#get '/seleccion' do
#  erb :all
#end

#get '/all' do
#  erb :all
#end
#
#get '/completed' do
#  erb :completed
#end
#
#get '/uncompleted' do
#  erb :uncompleted
#end

post '/seleccion' do
#  class UnknownCommandError < StandardError
#  end
#puts "PARAMS= #{params}" #############
  @tareas = Tarea.all
  if params[:seleccion]=="Inicio"
    redirect '/'
  elsif params[:seleccion]=="All"
#    redirect '/all'
    erb :all
  elsif params[:seleccion]=="Completed"
#    erb redirect '/completed'
    erb :completed
  elsif params[:seleccion]=="Uncompleted"
#    redirect '/uncompleted'
    erb :uncompleted
  else
    puts 'Aqui va el error'
    erb :all
  end
end

post '/seleccion/accion' do
  #puts "PARAMS: #{params}" ################
  if params[:accion]=="Agregar tarea"
    erb :add
  elsif params[:accion]=="Eliminar tarea"
    seleccionadas=params[:selected]
    erb :delete
  elsif params[:accion]=="Completar tarea"
    seleccionadas=params[:selected]
    erb :complete
  else
    puts 'Aqui va el error'
  end
end

post '/seleccion/accion/agregar' do
  #params[:seleccion]="All" ##############
  nuevaTarea = params[:nuevaTarea]
  #puts "PARAMS: #{params}" ##############
  Tarea.create("#{nuevaTarea}")
  redirect '/'
end

post '/seleccion/accion/eliminar' do
  #puts "SELECCIONADAS: #{seleccionadas}" ################
  @tareas = Tarea.all
  @tareas.each_with_index do |tarea, i|
    esta = seleccionadas.find { |numero| numero == i.to_s}
    if esta != nil
      id = @tareas[i]['id']
      #puts "ID: #{id}"
      Tarea.destroy(id)
    end
    #seleccionadas = []
  end
  redirect '/'
end

get '/seleccion/accion/completar' do
  @tareas = Tarea.all
  @tareas.each_with_index do |tarea, i|
    esta = seleccionadas.find { |numero| numero == i.to_s}
    if esta != nil
      id = @tareas[i]['id']
      #puts "ID: #{id}"
      Tarea.update(id)
    end
    #seleccionadas = []
  end
  redirect '/'
end
#post '/seleccion/seleccion2' do
#  class UnknownCommandError < StandardError
#  end
#  if params[:opcion2]=="Inicio"
#    redirect '/'
#  elsif params[:opcion2]=="Completed"
#    erb :completed
#  elsif params[:opcion2]=="Uncompleted"
#    erb :uncompleted
#  else
#    puts 'Aqui va el error'
#  end
#end

#post '/seleccion/seleccion3' do
#  if params[:opcion3]=="Inicio"
#    redirect '/'
#  elsif params[:opcion3]=="All"
#  erb :all
#  else
#    puts 'Aqui va el error'
#  end
#end

#post '/seleccion/seleccion4' do
#  if params[:opcion4]=="Inicio"
#    redirect '/'
#  elsif params[:opcion4]=="All"
#  erb :all
#  else
#    puts 'Aqui va el error'
#  end
#end
