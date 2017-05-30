require 'sinatra'
require 'sinatra/reloader' if development?
require 'make_todo'

seleccionadas = []

get '/' do
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
      puts "ID: #{id}"
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
      puts "ID: #{id}"
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
