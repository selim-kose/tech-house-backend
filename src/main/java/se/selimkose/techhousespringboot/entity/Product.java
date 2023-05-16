package se.selimkose.techhousespringboot.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.math.BigDecimal;

@Entity
@Data
@Table(name = "product")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "category_id")
    private ProductCategory category;
    private String name;
    private String description;
    private BigDecimal price;
    private String imageUrl;

}
