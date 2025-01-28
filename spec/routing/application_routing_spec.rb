require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it 'routes /users to users#index' do
    expect(get: '/users').to route_to('users#index')
  end

  it 'routes /users/:id to users#show' do
    expect(get: '/users/1').to route_to('users#show', id: '1')
  end

  it 'routes /users/details/:id to users#detailsshow' do
    expect(get: '/users/details/1').to route_to('users#detailsshow', id: '1')
  end

  # Testing timesheets route
  it 'routes /timesheets/fetchsingletimesheet to timesheets#fetch_single_timesheet' do
    expect(post: '/timesheets/fetchsingletimesheet').to route_to('timesheets#fetch_single_timesheet')
  end

  # Testing projects routes
  it 'routes /projects to projects#index' do
    expect(get: '/projects').to route_to('projects#index')
  end

  it 'routes /projects/:id to projects#show' do
    expect(get: '/projects/1').to route_to('projects#show', id: '1')
  end

  # Testing features routes
  it 'routes /users/execute_feature to hr/features#execute' do
    expect(post: '/users/execute_feature').to route_to('hr/features#execute')
  end

  it 'routes /users/checkinguserfeature to hr/features#checking_user_feature' do
    expect(post: '/users/checkinguserfeature').to route_to('hr/features#checking_user_feature')
  end

  it 'routes /users/features/index to hr/features#index' do
    expect(get: '/users/features/index').to route_to('hr/features#index')
  end

  # Testing profiles routes
  it 'routes /profiles to profiles#index' do
    expect(get: '/profiles').to route_to('profiles#index')
  end
end
