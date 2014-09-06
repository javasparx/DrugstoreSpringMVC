/*
 * Copyright 2012 - 2013 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package uz.javlon.webapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.solr.core.query.result.FacetFieldEntry;
import org.springframework.data.solr.core.query.result.FacetPage;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import uz.javlon.solr.model.Product;
import uz.javlon.solr.service.ProductService;

import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.Set;

/**
 * @author Christoph Strobl
 */
@Controller
@Component
@Scope("prototype")
public class SearchController {

    private ProductService productService;

    /*Fix for multiple items, when pressed next button*/
    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public String search(
            Model model,
            @RequestParam(value = "q[]", required = false) String[] query,
            @PageableDefault(page = 0, size = ProductService.DEFAULT_PAGE_SIZE) Pageable pageable) {

        model.addAttribute("page", productService.findByNames(query, pageable));
        model.addAttribute("pageable", pageable);
        model.addAttribute("query", query);
        return "search";
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String search() {
        return "search";
    }

    @ResponseBody
    @RequestMapping(value = "/autocomplete", produces = "application/json", method = RequestMethod.GET, headers = "Accept=application/json")
    public Set<String> autoComplete(Model model, @RequestParam("query") String query,
                                    @PageableDefault(page = 0, size = 1) Pageable pageable) {
        if (!StringUtils.hasText(query)) {
            return Collections.emptySet();
        }

        FacetPage<Product> result = productService.autocompleteNameFragment(query, pageable);

        Set<String> titles = new LinkedHashSet<String>();
        for (Page<FacetFieldEntry> page : result.getFacetResultPages()) {
            for (FacetFieldEntry entry : page) {
                if (entry.getValue().contains(query)) { // we have to do this as we do not use terms vector or a string field
                    titles.add(entry.getValue());
                }
            }
        }
        return titles;
    }

    @Autowired
    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

}
