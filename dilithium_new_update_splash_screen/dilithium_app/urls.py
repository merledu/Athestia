from django.urls import path
from . import views

urlpatterns = [
    path('', views.main_page ,name='main_page'),
    path('home/', views.main_page ,name='main_page'),
    path('about/',views.about,name="about"),
    path('getdstarted/', views.home, name='home'),
    path('download/', views.download_bitstream, name='download_bitstream'),
    path('download_vcd/', views.download_vcd, name='download_vcd'),
    #  path('simulation/', views.simulation, name='simulation')
]
