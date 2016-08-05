module ApplicationHelper
  def doctors_json(doctors)
    Gmaps4rails.build_markers(doctors) do |doctor, marker|
      marker.lat        doctor.latitude
      marker.lng        doctor.longitude
      marker.infowindow doctor.full_name
    end
  end
end
