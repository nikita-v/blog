module PostsHelper
  def full?
    controller.action_name == 'show'
  end
end