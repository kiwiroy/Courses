#!/usr/bin/perl
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

## Load the registry automatically
my $reg = "Bio::EnsEMBL::Registry";
$reg->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org');


## Get the compara genemember adaptor
my $gene_member_adaptor = $reg->get_adaptor("Multi", "compara", "GeneMember");

## Get the compara family adaptor
my $family_adaptor = $reg->get_adaptor("Multi", "compara", "Family");


## Get the compara member
my $gene_member = $gene_member_adaptor->fetch_by_source_stable_id("ENSEMBLGENE", "ENSG00000139618");

## Get all the families
my $all_families = $family_adaptor->fetch_all_by_Member($gene_member);

## For each family
foreach my $this_family (@{$all_families}) {
  print $this_family->description(), " (description score = ", $this_family->description_score(), ")\n";

  ## print the members in this family
  my $all_members = $this_family->get_all_Members();
  foreach my $this_member (@{$all_members}) {
    print $this_member->source_name(), " ", $this_member->stable_id(), " (", $this_member->taxon()->name(), ")\n";
  }
  print "\n";
}
