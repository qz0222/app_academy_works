class NotesController < ApplicationController

  def new

  end

  def create
    note = Note.new(track_id:params[:note][:track_id],user_id:(current_user.id),body:params[:note][:body])
    note.save!
    redirect_to track_url(note.track)
  end
end
