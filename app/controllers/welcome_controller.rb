class WelcomeController < ApplicationController
  def index
    @kids_section = [
      'after school programming',
      'childcare centers',
      'school supplies',
      'youth programs / special needs',
      'teen resources',
    ]
    @housing_section = [
      'housing',
      'rent assistance',
      'utility assistance',
    ]
    @education_section = [
      'training and education',
      'GED information',
    ]
    @health_section = [
        'free clinics',
        'addiction and recovery',
        'counseling',
    ]
    @food_and_goods_section = [
        'material assistance',
        'furniture',
        'clothing',
        'food pantries',
    ]

    @other_section = [
        'english as a 2nd language',
        'transportation services',
        'employment',
        'legal services',
        'budgeting help',
        'holiday assistance',
        'cell phones (computers and internet)',
    ]

  end
end
