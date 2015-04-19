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
      CRO005.png
      CRO006.png
      CRO007.png
      CRO008.png
    )
  end
end
