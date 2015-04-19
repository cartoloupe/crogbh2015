class WelcomeController < ApplicationController
  def index
    @other_section = [
      'veterans',
      'employment',
      'holiday assistance',
      'teen resources',
    ]

    @health_section = [
      'free clinics',
      'addiction and recovery',
      'counseling',
    ]

    @kids_section = [
      'after school programming',
      'childcare centers',
      'school supplies',
      'youth programs / special needs',
    ]

    @housing_section = [
      'housing',
      'rent assistance',
      'utility assistance',
    ]

    @education_section = [
      'training and education',
      'GED information',
      'english as a 2nd language',
    ]

    @food_and_goods_section = [
      'material assistance',
      'furniture',
      'clothing',
      'food pantries',
    ]

    @services_section = [
      'transportation services',
      'legal services',
      'budgeting help',
      'cell phones (computers and internet)',
    ]

  end
end
