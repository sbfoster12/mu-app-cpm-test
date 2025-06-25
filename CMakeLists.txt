# Download CPM.cmake if not already present
cmake_minimum_required(VERSION 3.14)

# Create project
project(mu_app_cpm_test VERSION 0.0.0 LANGUAGES CXX)

# C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set OS architecture
set(CMAKE_OSX_ARCHITECTURES "arm64")

# Create installation directories
set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install")

# Set the path for where to look for the libraries of the installed target
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/install/lib")

include(FetchContent)
FetchContent_Declare(
  CPM
  GIT_REPOSITORY https://github.com/cpm-cmake/CPM.cmake.git
  GIT_TAG v0.42.0
)
FetchContent_MakeAvailable(CPM)

# Add nlohmann_json
CPMAddPackage(
  NAME nlohmann_json
  GITHUB_REPOSITORY nlohmann/json
  GIT_TAG v3.11.3
)
# Append CMAKE_PREFIX_PATH to include this install of nlohmann_json
# list(APPEND CMAKE_PREFIX_PATH "${nlohmann_json_BINARY_DIR}")

# Add data procucts library
CPMAddPackage(
  NAME data_products
  GIT_REPOSITORY https://github.com/sbfoster12/mu-data-products.git
  GIT_TAG main
)

# if(TARGET data_products AND NOT TARGET DataProducts::data_products)
#   add_library(DataProducts::data_products ALIAS data_products)
# endif()

# Add unpacker library
CPMAddPackage(
  NAME unpackers
  GIT_REPOSITORY https://github.com/sbfoster12/mu-unpackers.git
  GIT_TAG feature/cpm
)

add_executable(mu_app_cpm main.cpp)
target_link_libraries(mu_app_cpm
    PRIVATE
        data_products
        unpackers
)

# Install the executable
install(TARGETS mu_app_cpm
        DESTINATION bin
)