class PitchController < ApplicationController
  def index
    #@images = (1..8).map{|n|
    #  "CRO#{sprintf "%03d", n}.png"
    #}
    @images = %w(
      CRO001.png
      CRO002.png
      CRO003.png
      CRO004.png
      CRO006.png
      CRO007.png
      CRO008.png
      CRO009.png
      CRO010.png
      CRO011.png
      CRO012.png
      CRO013.png
      CRODEMO1.png
    )
    #MAP001.png
    #MAP002.png
  end
end
