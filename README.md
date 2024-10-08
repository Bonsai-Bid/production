<br></br>
## Status
10/8 Update
I moved everything from vanilla javascript into stimulus controllers and am now making all the old tests pass again, but I think that should be relatively quick process (fingers crossed)

This app is still in development. While a testing model is deployed to Heroku, it has not implemented most of the designers ideas. I am happy to provide a link if you would like to look around. 

Normally this repo is private but I have it open right now for presentation purposes, when this launches this will be private again - Brendan
<br></br>


<div align="center">
<h1> Bonsai Bid </h1>

## :computer: Tech Stack <br>
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)
![Notion](https://img.shields.io/badge/Notion-%23000000.svg?style=for-the-badge&logo=notion&logoColor=white)
![Github Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![Heroku](https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white)
![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![YAML](https://img.shields.io/badge/yaml-%23ffffff.svg?style=for-the-badge&logo=yaml&logoColor=151515)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Redis](https://img.shields.io/badge/redis-%23DC382D.svg?style=for-the-badge&logo=redis&logoColor=white)
![Sidekiq](https://img.shields.io/badge/sidekiq-%23DC382D.svg?style=for-the-badge&logo=sidekiq&logoColor=white)
![AWS](https://img.shields.io/badge/Amazon%20AWS-%23232F3E.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-%23563D7C.svg?style=for-the-badge&logo=bootstrap&logoColor=white)
![Vite](https://img.shields.io/badge/Vite-%23646CFF.svg?style=for-the-badge&logo=vite&logoColor=white)
![Stimulus](https://img.shields.io/badge/Stimulus-%23D94E78.svg?style=for-the-badge&logo=stimulus&logoColor=white)
![Nokogiri](https://img.shields.io/badge/Nokogiri-%23E95420.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Selenium](https://img.shields.io/badge/Selenium-%2343B02A.svg?style=for-the-badge&logo=selenium&logoColor=white)
![RSpec](https://img.shields.io/badge/RSpec-%23FFC107.svg?style=for-the-badge&logo=rspec&logoColor=white)
</div>

## :closed_book: Abstract

Bonsai Bid is a simple, yet powerful online auction platform dedicated to serving the national community of bonsai enthusiasts. Inspired by the bustling, yet inefficient bonsai trading within private Facebook groups, Bonsai Bid is designed to streamline and elevate the buying and selling experience. Our mission is to create a user-friendly, bonsai-specific marketplace that produces unparalleled experiences for both the buyer and seller.




### Features and Functionalities
#### Auction Management 
Users can view active auctions, place bids, and track auction status updates in real-time. The platform handles the entire auction lifecycle, from listing items to finalizing sales.

#### Dynamic Form Handling 
The application dynamically displays form fields based on user input, making the experience intuitive and efficient. For example, selecting different item categories (Plant, Container, Essential) adjusts the available attributes.

#### Image Management
Bonsai Bid supports scalable image uploads for auction items, ensuring high-quality visuals are displayed with each listing.

#### User Authentication and Profiles
Built with Devise, Bonsai Bid offers secure user registration and login functionalities. Each user profile can store preferences and contact information, which the system uses to personalize the experience.

#### Countdown Timers
Real-time countdown timers for auctions keep users informed of the time remaining, enhancing the bidding excitement.

### Testing and Quality Assurance
#### RSpec 
The application employs a robust RSpec testing suite with at least 95% coverage, ensuring all critical functionalities are well-tested. Cucumber tests are also used for behavior-driven development, verifying the application's behavior aligns with user expectations.

#### Continuous Integration 
GitHub Actions is used for CI/CD, automating tests on each commit to ensure new code does not introduce regressions. The pipeline includes linting, security checks, and automated deployment processes.

#### Performance Monitoring 
Skylight is integrated into the application to monitor performance, detect bottlenecks, and provide insights into request processing times.

#### Security Audits 
Tools like Brakeman and Bundler Audit are employed to scan the application for potential vulnerabilities, ensuring that security best practices are adhered to.

### Additional Technologies
#### Background Jobs 
Sidekiq with Redis is used to handle background jobs efficiently, such as sending emails or processing image uploads.

#### Asset Management 
The application leverages Vite and Bootstrap for modern front-end asset management, ensuring a responsive and visually appealing interface.

#### Deployment 
Bonsai Bid is deployed on Heroku, taking advantage of its easy scalability and managed environment.

#### Authors
[Brendan Bondurant](https://www.linkedin.com/in/brendanbondurant) | [Github](https://github.com/brendan-bondurant)
<br></br>

</div>









