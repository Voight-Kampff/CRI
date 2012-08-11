# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CriDashboard::Application.initialize!

@@date=(Date.today<<1).beginning_of_month

NA= 'Data missing'