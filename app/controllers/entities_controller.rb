class EntitiesController < ApplicationController
  def show
    begin
      render json: entity
    rescue ActiveRecord::RecordNotFound => e
      render text: "Could not find entity.", status: :not_found
    end
  end

  def destroy
    entity.destroy
    head :ok
  end

  def tag
    entity = EntityTagger.new(tag_parameters).tag
   render json: entity
  end

  private
  def entity
    @entiy ||= Entity.find(params[:id])
  end

  def tag_parameters
    params.require(:entity).permit(:type, :id, tags: [])
  end
end