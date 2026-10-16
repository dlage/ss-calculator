require 'test_helper'

class TaxReferenceTest < ActiveSupport::TestCase
  test 'calculates worker employer and total contributions' do
    reference = tax_references(:current)
    assert_in_delta 110.0, reference.worker_contribution(100), 0.000001
    assert_in_delta 237.5, reference.employer_contribution(100), 0.000001
    assert_in_delta 347.5, reference.total_contribution(100), 0.000001
  end

  test 'zero hours produce zero contributions' do
    assert_equal 0, tax_references(:current).total_contribution(0)
  end

  test 'orders years newest first and rejects duplicate years' do
    assert_equal [2026, 2025], TaxReference.pluck(:year)
    reference = tax_references(:current).dup
    assert_not reference.valid?
    assert reference.errors.added?(:year, :taken, value: 2026)
  end
end
