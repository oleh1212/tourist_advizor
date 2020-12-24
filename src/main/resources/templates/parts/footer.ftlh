<#import "/spring.ftl" as spring/>
<!-- Footer -->
<footer class="page-footer font-small mdb-color lighten-3  mt-5 " id="foot">

    <!-- Footer Links -->
    <div class="container text-center text-md-left">

        <!-- Grid row -->
        <div class="row">

            <!-- Grid column -->
            <div class="col-md-4 col-lg-3 mr-auto my-md-4 my-0 mt-4 mb-1">

                <!-- Content -->
                <h5 class="font-weight-bold text-uppercase mb-4"><@spring.message "lang.content.name"/></h5>
                <p><@spring.message "lang.footer.content"/></p>

            </div>
            <!-- Grid column -->

            <hr class="clearfix w-100 d-md-none"/>

            <hr class="clearfix w-100 d-md-none"/>

            <!-- Grid column -->
            <div class="col-md-4 col-lg-3 mx-auto my-md-4 my-0 mt-4 mb-1">

                <!-- Contact details -->
                <h5 class="font-weight-bold text-uppercase mb-4"><@spring.message "lang.footer.addres"/></h5>

                <ul class="list-unstyled">
                    <li>
                        <p>
                            <i class="fas fa-home mr-3"></i> New York, NY 10012, US</p>
                    </li>
                    <li>
                        <p>
                            <i class="fas fa-envelope mr-3"></i> info@example.com</p>
                    </li>
                    <li>
                        <p>
                            <i class="fas fa-phone mr-3"></i> + 01 234 567 88</p>
                    </li>
                </ul>

            </div>
            <!-- Grid column -->

            <hr class="clearfix w-100 d-md-none"/>

            <!-- Grid column -->
            <div class="col-md-2 col-lg-2 text-center mx-auto my-4">

                <!-- Social buttons -->
                <h5 class="font-weight-bold text-uppercase mb-4"><@spring.message "lang.footer.follow"/></h5>

                <!-- Facebook -->
                <a type="button" class="btn-floating btn-fb">
                    <i class="fab fa-telegram-plane"></i>
                </a>
                <!-- Twitter -->
                <a type="button" class="btn-floating btn-tw">
                    <i class="fab fa-twitter"></i>
                </a>
                <!-- Google +-->
                <a type="button" class="btn-floating btn-gplus">
                    <i class="fab fa-google-plus-g"></i>
                </a>
                <!-- Dribbble -->
                <a type="button" class="btn-floating btn-dribbble">
                    <i class="fab fa-instagram"></i>
                </a>

            </div>
            <!-- Grid column -->

        </div>
        <!-- Grid row -->

    </div>
    <!-- Footer Links -->

    <!-- Copyright -->
    <div class="footer-copyright text-center ">© 2018 Copyright:
        <a href="https://mdbootstrap.com/education/bootstrap/"> MDBootstrap.com</a>
    </div>
    <!-- Copyright -->

</footer>
<!-- Footer -->