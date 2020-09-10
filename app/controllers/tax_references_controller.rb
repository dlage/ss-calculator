class TaxReferencesController < ApplicationController
  def index
    @tax_references = TaxReference.all
  end

  def show
    @tax_references = TaxReference.all
    @tax_reference = TaxReference.find_by(year: params[:year])
  end
end
