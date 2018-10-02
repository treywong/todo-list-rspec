require "rspec"
require "rspec-given"
require_relative "list"
require_relative "task"

describe List do
  Given(:title) { "TO-DO LIST" }
  Given(:list) { List.new(title) }

  Given(:description_1) { "Walk the giraffe" }
  Given(:task_1) { Task.new(description_1) }

  Given(:description_2) { "Walk the dog" }
  Given(:task_2) { Task.new(description_2) }

  Given(:description_3) { "Walk the cat" }
  Given(:task_3) { Task.new(description_3) }

  Given(:example) { List.new(title,[task_1]) }
  Given(:example_full) { List.new(title,[task_1, task_2, task_3]) }


  describe "#initialize" do
    context "takes a title for its first argument with an empty tasks array" do
      When (:output){List.new(title)}
      Then {expect(output).to be_a_kind_of(List)}
    end
    
    context "requires one argument" do
      Then {expect{List.new}.to raise_error(ArgumentError)} # noticed we used {Task.new} instead of (Task.new)? With () is to test the return value, {} is to test the behavior
    end
  end

  #Stack level too deep
  describe "#add_task" do
    context "Add a task into the tasks array" do
      When { list.add_task(task_1) }
      Then { expect(list.tasks).to include(task_1) }
    end
  end

  describe "#complete_task" do
    context "Change task status to complete" do
      When { example.complete_task(0) }
      Then { example.tasks[0].complete? == true }
    end
  end

  describe "#delete_task" do
    context "Delete task from list" do
      When { example.delete_task(0) }
      Then { example.tasks[0] == nil }
    end
  end

# I'm not sure if this works
  # describe "#completed_tasks" do
  #   context "Select complete tasks from list" do
  #     When { example_full.tasks[1].complete! }
  #     When { example_full.completed_tasks }
  #     Then { example_full.tasks.each { |t| t.complete? == true} }
  #   end

  #   context "Only 1 task was completed" do
  #     When { example_full.tasks[1].complete! }
  #     When { example_full.completed_tasks }
  #     Then { example_full.tasks.length == 1 }
  #   end
  # end

  # describe "#incomplete_tasks" do
  #   context "Select incomplete tasks from list" do
  #     When { example_full.tasks[1].complete! }
  #     When { example_full.incomplete_tasks }
  #     Then { example_full.tasks.each { |t| t.complete? == false} }
  #   end

  #   context "Only 2 task are incomplete" do
  #     When { example_full.tasks[1].complete! }
  #     When { example_full.incomplete_tasks }
  #     Then { example_full.tasks.length == 2 }
  #   end
  # end

  describe "#completed_tasks" do
    context "Select complete tasks from list" do
      When { example_full.tasks[1].complete! }
      Then { example_full.completed_tasks == [task_2] }

      # Then { puts example_full.tasks.select {|t| t } }
    end
  end

  describe "#incomplete_tasks" do
    context "Select incomplete tasks from list" do
   	  When { example_full.tasks[1].complete! }
      Then { example_full.incomplete_tasks == [task_1, task_3]}
    end
  end

end

# rspec list_spec.rb
