class WelcomeController < ApplicationController
  def index
    @categories = Category.all


    # keep this around as a list for now
    # should be moved to:
    # https://github.com/cartoloupe/crogbh2015/blob/master/notes/categories.md
    @all_the_sections = [
      @other_section = [
        'holiday assistance',
        'teen resources',
      ],

      @health_section = [
        'addiction and recovery',
        'counseling',
      ],

      @kids_section = [
        'after school programming',
        'childcare centers',
        'school supplies',
        'youth programs / special needs',
      ],

      @housing_section = [
        'housing',
        'rent assistance',
        'utility assistance',
      ],

      @education_section = [
        'training and education',
        'GED information',
        'english as a 2nd language',
      ],

      @food_and_goods_section = [
        'material assistance',
        'furniture',
        'clothing',
        'food pantries',
      ],

      @services_section = [
        'transportation services',
        'legal services',
        'budgeting help',
        'cell phones (computers and internet)',
        'veterans',
        'employment',
        'pregnancy support',
      ],
    ].flatten

  end
end
