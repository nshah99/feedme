class EventsController < ApplicationController
  def new
    @event = Event.new
    @user = User.find(params[:user_id])
  end

  def create
    
    @user = User.find(params[:user_id])
    @event = Event.new(event_params)
    @event.event_time = params[:event_time]
    ts = @event.event_time
    ds = @event.event_date

    @event.event_time = DateTime.new(ds.year,ds.month,ds.day,ts.hour,ts.min,ts.sec)
    if @event.save
      flash[:success] = "Great Success"
       @user.events << @event
       
      redirect_to @event  #user_event_path(@user,@event)
    else
      render 'new'
    end
  end
  
  def attend
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])

    @user.events << @event
    flash[:success] = "Great success"
    redirect_to @event
  end
  def index
    #@user = User.find(params[:user_id])
    @event = Event.all
  end

  def update
  end

  def edit
  end

  def delete
  end

  def show
    #@user = User.find(params[:user_id])
    @event = Event.find(params[:id])
  end
  
  def event_params
    params.require(:event).permit(:title,:description,:address,:event_date,:event_time)
  end
end
